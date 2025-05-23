package user

import (
	"fmt"
	"time"
)

func (s *UserService) CheckPin(username string, pin string, refcode string) (string, int, error) {
	// Check user existence
	userId, err := s.Model.GetUserIdWithUsername(username)
	if err != nil {
		return "", 401, fmt.Errorf("ไม่พบผู้ใช้")
	}

	fullRefCode, systempin, datetime, err := s.Model.CheckPin(userId, refcode)
	if err != nil {
		return "", 401, fmt.Errorf("OTP ไม่ถูกต้อง")

	}

	if datetime.UTC().Before(time.Now().UTC().Add(-15 * time.Minute)) {
		return "", 401, fmt.Errorf("OTP หมดอายุ")
	}

	if systempin != pin {
		return "", 401, fmt.Errorf("OTP ไม่ถูกต้อง")
	}

	return fullRefCode, 200, nil
}
