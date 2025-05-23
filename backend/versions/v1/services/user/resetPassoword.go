package user

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func (s *UserService) ResetPassword(username string, fullRefCode string, newpassword string) (int, error) {
	userIdFromUname, err := s.Model.GetUserIdWithUsername(username)
	if err != nil {
		return 401, fmt.Errorf("ไม่พบผู้ใช้")
	}

	userIdFromRefCode, err := s.Model.GetUserIdWithFullRefCode(fullRefCode)
	if err != nil {
		return 401, fmt.Errorf("รหัสอ้างอิงไม่ถูกต้อง")
	}

	if userIdFromUname != userIdFromRefCode {
		return 401, fmt.Errorf("รหัสอ้างอิงไม่ถูกต้อง")
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(newpassword), 12)
	if err != nil {
		return 500, fmt.Errorf("เกิดข้อผิดพลาดในการเข้ารหัสรหัสผ่าน")
	}

	err = s.Model.UpdatePassword(userIdFromUname, string(hashedPassword))
	if err != nil {
		fmt.Println(err)
		return 500, fmt.Errorf("เกิดข้อผิดพลาดในการอัปเดตรหัสผ่าน")
	}

	return 200, nil
}
