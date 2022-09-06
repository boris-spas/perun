#!/usr/bin/env bash
/usr/bin/test "$(../Perun echo_foo)" == "foo"
/usr/bin/test "$(../Perun echo_foo bar)" == "foo"
/usr/bin/test "$(../Perun echo_bar_and_args)" == "bar"
/usr/bin/test "$(../Perun echo_bar_and_args arg)" == "bar arg"
/usr/bin/test "$(../Perun echo_bar_and_args arg1 arg2)" == "bar arg1 arg2"
/usr/bin/test "$(../Perun echo_empty_or_first_arg)" == "empty"
/usr/bin/test "$(../Perun echo_empty_or_first_arg foo)" == "foo"
/usr/bin/test "$(../Perun testArgMap)" == "NOT_PROVIDED"
/usr/bin/test "$(../Perun testArgMap -d foo)" == "foo"
/usr/bin/test "$(../Perun testArgMap -d)" == " "
/usr/bin/test "$(../Perun testArgMap -d -t)" == " "
/usr/bin/test "$(../Perun testArgMap -t -d)" == " "
/usr/bin/test "$(../Perun testArgs -d foo bar baz)" == "bar baz "
/usr/bin/test "$(../Perun testArgs foo -d bar baz)" == "foo baz "
/usr/bin/test "$(../Perun testArgs foo bar -d baz)" == "foo bar "
mkdir dir_without_perunfile
(
cd dir_without_perunfile
# Intentionally fails cause no task was given
EDITOR="cat"
/usr/bin/test "! $(../../Perun <<< 'Y')"
/usr/bin/test "$(head -n 1 Perunfile)" == '#!/bin/bash'
/usr/bin/test "$(../../Perun _s test 'echo foo')"
/usr/bin/test "$(../../Perun test)" == "foo"
)
rm -rf dir_without_perunfile
