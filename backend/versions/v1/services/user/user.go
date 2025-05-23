package user

import (
	mailModel "rcu/versions/v1/models/mail"
	userModel "rcu/versions/v1/models/user"
)

type UserService struct {
	Model     *userModel.UserModel
	MailModel *mailModel.MailModel
}

func (s *UserService) GetMessage() string {
	return ""
}
