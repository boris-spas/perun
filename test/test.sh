#!/usr/bin/env bash
test "$(../Perun echo_foo)" == "foo"
test "$(../Perun echo_foo bar)" == "foo"
test "$(../Perun echo_bar_and_args)" == "bar"
test "$(../Perun echo_bar_and_args arg)" == "bar arg"
test "$(../Perun echo_bar_and_args arg1 arg2)" == "bar arg1 arg2"
test "$(../Perun echo_empty_or_first_arg)" == "empty"
test "$(../Perun echo_empty_or_first_arg foo)" == "foo"
test "$(../Perun testArgMap)" == "NOT_PROVIDED"
test "$(../Perun testArgMap -d foo)" == "foo"
test "$(../Perun testArgMap -d)" == " "
test "$(../Perun testArgMap -d -t)" == " "
test "$(../Perun testArgMap -t -d)" == " "
test "$(../Perun testArgs -d foo bar baz)" == "bar baz "
test "$(../Perun testArgs foo -d bar baz)" == "foo baz "
test "$(../Perun testArgs foo bar -d baz)" == "foo bar "
mkdir dir_without_perunfile
(
cd dir_without_perunfile
EDITOR="cat"
# Intentionally fails cause no task was given
test "! $(../../Perun <<< 'Y')"
test "$(head -n 1 Perunfile)" == '#!/bin/bash'
test "$(../../Perun _s test 'echo foo')"
test "$(../../Perun test)" == "foo"
)
rm -rf dir_without_perunfile
