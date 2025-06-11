package user

import (
	userService "rcu/versions/v1/services/user"
)

type UserController struct {
	Service *userService.UserService
}
