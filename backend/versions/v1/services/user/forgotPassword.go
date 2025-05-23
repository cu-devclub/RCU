package user

import (
	"fmt"
	"math/rand"
)

func (s *UserService) ForgotPassword(username string, ip string) (string, int, error) {

	// Check user existence
	userId, err := s.Model.GetUserIdWithUsername(username)
	if err != nil {
		return "", 401, err
	}

	// Generate a random 6-digit PIN
	num := rand.Intn(1000000)
	strNum := fmt.Sprintf("%06d", num)

	// Insert the reset PIN into the database
	refCode, err := s.Model.InsertResetPin(userId, strNum)
	if err != nil {
		return "", 500, err
	}

	refCode = refCode[len(refCode)-4:]

	targetMail, err := s.Model.GetUserEMail(userId)
	if err != nil {
		return "", 500, err
	}

	// Send the reset PIN to the user's email
	err = s.MailModel.SendResetPasswordMail(targetMail, strNum, ip, refCode)
	if err != nil {
		return "", 500, err
	}

	return refCode, 200, nil
}
