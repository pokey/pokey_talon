tag: user.code_operators_bitwise
-

#bitwise operators
[<user.operator>] bitwise and: user.code_operator_bitwise_and()
[<user.operator>] bitwise or: user.code_operator_bitwise_or()

# TODO: split these out into separate logical and bitwise operator commands

(<user.operator> | logical | bitwise) (ex | exclusive) or:
    user.code_operator_bitwise_exclusive_or()
(<user.operator> | logical | bitwise) (left shift | shift left):
    user.code_operator_bitwise_left_shift()
(<user.operator> | logical | bitwise) (right shift | shift right):
    user.code_operator_bitwise_right_shift()
