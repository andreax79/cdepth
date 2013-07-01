#
# Copyright (c) 2013, Andrea Bonomi <andrea.bonomi@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#
# INSTALL:
#
# Put something like this in your .bashrc/.zshrc:
# . /path/to/cdepth.sh
#

cdepth() {

    get_depth() {
        local tmp=$PWD
        local depth=1
        while [ $tmp != "/" ]; do
            tmp=$(dirname $tmp)
            ((depth++))
        done
        echo $depth
    }

    print_depth() {
        local depth=$(get_depth)
        local d=0
        ((depth--))
        local tmp=$PWD
        while [ $tmp != "/" ]; do
            local t=-$d
            printf "%4s %4s %s\n" $depth $t $tmp
            tmp=$(dirname $tmp)
            ((depth--))
            ((d++))
        done
        local t=-$d
        printf "%4s %4s %s\n" $depth $t $tmp
    }

    change_depth() {
        local new_depth=$1
        local depth=$(get_depth)
        local d=0
        ((depth--))
        local tmp=$PWD
        while [ $tmp != "/" ]; do
            local t=-$d
            if [ "$new_depth" = "$depth" -o "$new_depth" = "$t" ]; then
                cd $tmp
                return 0
            fi
            tmp=$(dirname $tmp)
            ((depth--))
            ((d++))
        done
        local t=-$d
        if [ "$new_depth" = "$depth" -o "$new_depth" = "$t" ]; then
            cd $tmp
            return 0
        fi
        return 1
    }

    if [ "$1" == "" ]; then
        print_depth
    else
        change_depth $1
        return $?
    fi

}
