# How weather plugin works

in shell.sh we call

    weather

in plugins/st.sh we expand this function:

    weather()
    {
        echo -n " $(weather_main) |"
    }

which calls:

    weather_main(){

    # fetch data if files is 30 minutes old
    if test "`find /dev/shm/weather -mmin +30`"
    then
        weather_get_the_data
    fi

    # if the file is empty, try again to fetch the data
    if test ! -s /dev/shm/weather
    then
        weather_get_the_data
    fi

    weather_test_size

    # check size of the file before setting the variables
    if [ $(cat /dev/shm/weather | wc -l) -lt 20 ]; then
        B="-----"
        # retry in less time
        if test "`find /dev/shm/weather -mmin +5`"
        then
        weather_get_the_data
        fi
    else
        weather_format_data
    fi
    }

now we need to see weather_get_the_data, weather_test_size and
weather_format_data

weather_get_the_data only does a curl a saves to a file:

    weather_get_the_data()
    {
    LOCATION=Brno
    #LOCATION=Prague
    #LOCATION=Nova_iguacu
    curl -m 5 wttr.in/"$LOCATION" | \
        sed -r "s/\x1B\[(([0-9]+)(;[0-9]+)*)?[m,K,H,f,J]//g" \
        > /dev/shm/weather
    }


