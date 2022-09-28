tag: user.code_operators_assignment
-
tag(): user.code_operators_math
tag(): user.code_operators_bitwise

# assignment
<user.operator> (equals | a sign): user.code_operator_assignment()

# combined computation and assignment
<user.operator> (minus | subtract) equals:
    user.code_operator_subtraction_assignment()
<user.operator> (plus | add) equals: user.code_operator_addition_assignment()
<user.operator> (times | multiply) equals:
    user.code_operator_multiplication_assignment()
<user.operator> divide equals: user.code_operator_division_assignment()
<user.operator> mod equals: user.code_operator_modulo_assignment()
[<user.operator>] increment: user.code_operator_increment()

#bitwise operators
(<user.operator> | logical | bitwise) (ex | exclusive) or equals:
    user.code_operator_bitwise_exclusive_or_assignment()
[(<user.operator> | logical | bitwise)] (left shift | shift left) equals:
    user.code_operator_bitwise_left_shift_assignment()
[(<user.operator> | logical | bitwise)] (right shift | shift right) equals:
    user.code_operator_bitwise_right_shift_assignment()
