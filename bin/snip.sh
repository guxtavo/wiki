#!/bin/bash
# 
# Copyright 2016-2019 Martin Goellnitz
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
if [ `jq 2>&1|wc -l` = 0 ] ; then
  echo "To use this tool, jq must be installed."
  exit
fi
if [ "$1" == "-h" ]; then
  echo "GitLab Project Code Snippet Command Line Tool 'snip.sh'"
  echo ""
  echo "$0 [ -u instance url] [-p project] [-t token] [-i] [-a] filename [Title]"
  echo ""
  echo "If 'filename' points to an existing file, it is uploaded to Gitlab with an optional title."
  echo "If 'filename' describes a filename present in the given project, it is downloaded."
  echo "If 'filename' describes a filename present in any of your projects and you don't mention one of them, the project is automatically discovered."
  echo "If 'filename' is not present, the available snippets in the project are listed."
  echo ""
  echo "  -u instance base url - default https://gitlab.com"
  echo ""
  echo "  -p project name with user or group name"
  echo ""
  echo "  -t gitlab api token - default \$GITLAB_COM_TOKEN"
  echo ""
  echo "  -d delete snippet"
  echo ""
  echo "  -i make internally visible for logged in users"
  echo ""
  echo "  -a make publicly visible for all"
  echo ""
  echo "  -h this help message"
  echo ""
  echo "So the default action is to list all projects available to the user identified with the access token."
  echo ""
  exit 1
fi

# defaults
GITLAB="https://gitlab.suse.de"
TOKEN=$GITLAB_COM_TOKEN
# private, internal and public
VISIBILITY="public"

PSTART=`echo $1|sed -e 's/^\(.\).*/\1/g'`
while [ "$PSTART" = "-" ] ; do
  if [ "$1" = "-u" ] ; then
    shift
    GITLAB="$1"
  fi
  if [ "$1" = "-p" ] ; then
    shift
    PROJECT="$1"
  fi
  if [ "$1" = "-t" ] ; then
    shift
    TOKEN="$1"
  fi
  if [ "$1" = "-d" ] ; then
    DELETE="delete"
  fi
  if [ "$1" = "-a" ] ; then
    VISIBILITY="public"
  fi
  if [ "$1" = "-i" ] ; then
    VISIBILITY="internal"
  fi
  shift
  PSTART=`echo $1|sed -e 's/^\(.\).*/\1/g'`
done
FILEPATH=$1
TITLE=$2
HEADER="PRIVATE-TOKEN: $TOKEN"
# echo project: $PROJECT title: $TITLE file: $FILEPATH gitlab: $GITLAB with token $TOKEN
if [ ! -z "$PROJECT" ] ; then
  PID=`echo $PROJECT|sed -e 's/\//%2F/g'`
  # echo "project ID for $PROJECT is $PID"
  URLADD="/projects/$PID"
  CHECK=$(curl -k -H "$HEADER" ${GITLAB}/api/v4$URLADD 2> /dev/null|grep "404"|wc -l)
  if [ "$CHECK" -eq "1" ] ; then
    echo "Unknown project $PROJECT on $GITLAB ($TOKEN)"
    exit 1
  fi
else
  if [ -z "$TOKEN" ] ; then
    echo "Cannot work without the context of a project or user. Sorry... Use -h for help."
    exit 1
  fi
fi
if [ -z "$FILEPATH" ] ; then
  if [ -z "$PROJECT" ] ; then
    echo "Listing snippet files available to the current user at $GITLAB"
  else
    echo "Listing snippet files in $GITLAB/$PROJECT"
  fi
  curl -k -H "$HEADER" ${GITLAB}/api/v4$URLADD/snippets 2> /dev/null|jq '.[]|.file_name'|sed -e s/^\"//g|sed -e s/\"$//g
else
  FILE=`basename $FILEPATH`
  SNID=$(curl -k -H "$HEADER" ${GITLAB}/api/v4$URLADD/snippets 2> /dev/null|jq '.[]|select(.file_name=="'$FILE'")|.id')
  # echo $SNID
  if [ ! -z "$SNID" ] ; then
    PROJECT=$(curl -k -H "$HEADER" ${GITLAB}/api/v4$URLADD/snippets 2> /dev/null \
        |jq '.[]|select(.file_name=="'$FILE'")|.web_url' \
        |head -1|sed -e s/^\"//g|sed -e s/\"$//g \
        |sed -e 's/\(^.*:\/\/[A-Z0-9a-z\.]*\)\/\([A-Z0-9a-z\.]*\/[A-Z0-9a-z\.]*\).*/\2/g')
    # echo "Snippet project: $PROJECT"
    SNURL=${GITLAB}/api/v4/projects/$PID/snippets/${SNID}
  fi
  # echo "Snurl: $SNURL"
  if [ ! -z "$DELETE" ] ; then
    if [ -z "$SNURL" ] ; then
      echo "No snippet '$FILE' found in $GITLAB/$PROJECT to delete"
    else
      echo "Deleting snippet '$FILE' from $GITLAB/$PROJECT"
      # curl -k -X DELETE -H "$HEADER" ${SNURL} 2> /dev/null > /dev/null
      curl -k -X DELETE -H "$HEADER" ${SNURL} 2> /dev/null
    fi
  else
    if [ -f $FILEPATH ] ; then
      if [ -z "$SNURL" ] ; then
        if [ -z "$TITLE" ] ; then
          TITLE=$FILE
        fi
        echo "Creating snippet '$FILE' with title '$TITLE' in $GITLAB/$PROJECT from '$FILEPATH'"
        curl -k -H "$HEADER" -H "Content-Type: application/json" \
             -d "{ \"title\": \"$TITLE\", \"file_name\": \"$FILE\", \"visibility\": \"$VISIBILITY\", \"content\": \"$(cat $FILEPATH)\" }" \
             ${GITLAB}/api/v4$URLADD/snippets 2> /dev/null
      else
        if [ -z "$TITLE" ] ; then
          echo "Updating snippet '$FILE' in $GITLAB/$PROJECT"
          curl -k -X PUT -H "$HEADER" -F "code=<$FILEPATH" -F "file_name=$FILE" -F "visibility_level=$VISIBILITY" ${SNURL} 2> /dev/null > /dev/null
          curl -k -H "$HEADER" -H "Content-Type: application/json" \
               -d "{ \"file_name\": \"$FILE\", \"visibility\": \"$VISIBILITY\", \"content\": \"$(cat $FILEPATH)\" }" \
               ${SNURL} 2> /dev/null > /dev/null  
        else
          echo "Updating snippet '$FILE' with title '$TITLE' in $GITLAB/$PROJECT"
          curl -k -X PUT -H "$HEADER" -F "code=<$FILEPATH" -F "file_name=$FILE" -F "title=$TITLE" -F "visibility_level=$VISIBILITY" ${SNURL} 2> /dev/null > /dev/null
          curl -k -H "$HEADER" -H "Content-Type: application/json" \
               -d "{ \"title\": \"$TITLE\", \"file_name\": \"$FILE\", \"visibility\": \"$VISIBILITY\", \"content\": \"$(cat $FILEPATH)\" }" \
               ${SNURL} 2> /dev/null > /dev/null
        fi
      fi
    else
      echo "Fetching snippet '$FILE' as '$FILEPATH' from $GITLAB/$PROJECT"
      curl -k -H "$HEADER" ${SNURL} 2> /dev/null > $FILEPATH
      CHECK=`grep "^..message...404.Not.found" $FILEPATH`
      if [ ! -z "$CHECK" ] ; then
        echo "'$FILEPATH' not found in $GITLAB/$PROJECT"
        rm $FILEPATH
      fi
    fi
  fi
fi
