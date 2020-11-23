Chapter 6: Structures

A structure is a collection of one or more variables, possibly of
different types, grouped together under a single name for convenient
handling. (Structures are called "records" in some languages, notably
Pascal.) Structures help to organize complicated data, particularly in
large programs, because they permit a group of related variables to be
treated as a unit instead of as separate entities.

One traditional example of a structure is the payroll record: an
employee is described by a set of attributes such as name, address,
social security number, salary, etc. Some of these in turn could be
strutures: a name has several components, as does an address and even a
salary. Another example, more typical for C, comes from graphics: a
point is a pair of coordinates, a rectangle is a pair of points, and so
on.

The main change made by the ANSI standard is to define structure
assignment - structures may be copied and assigned to, passed to
functions, and returned by functions. This has been supported by most
compilers for many years, but the properties are now precisely defined.
Automatic structures and arrays may now also be initialized.

6.1 Basics of structures

Let us create a few structures suitable for graphics. The basic object
is a point, which we will assume has an x coordinate and a y coordinate,
both integers.

        y

        ^
        |
        +
        |
        +
        |
        +               .(4,3)
        |
        +
        |
        +
        |
  ------.---+---+---+---+---+---+-----> x
   (0,0)|
        |

The two components can be placed in a structure declared like this:

    struct point {
        int x;
        int y;
    };

The keyword _struct_ introduces a structure declaration, which is a list
of declarations enclosed in braces. An optional name called a _structure
tag_ may follow the word struct (as with point here). The tag names this
kind of structure, and can be used subsequently as a shorthand for the
part of the declaration in braces.

The variables named in a structure are called _members_. A structure
member or tag and and ordinary (i.e., non-member) variable can have the
same name without conflict, since they can always be distinguished by
context. Futhermore, the same member names may occur in different
structures, although as a matter of style one would normally use the
same names only for closely related objects.

A struct declaration defines a type. The right brace that terminates
