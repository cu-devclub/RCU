package user

import (
	"database/sql"
	"fmt"
)

func (m *UserModel) GetUserIdWithUsername(username string) (string, error) {
	var userID int
	query := `SELECT id FROM "user" WHERE username = $1`

	err := m.DB.QueryRow(query, username).Scan(&userID)
	if err != nil {
		if err == sql.ErrNoRows {
			return "", fmt.Errorf("user not found")
		}
		return "", err
	}

	return fmt.Sprintf("%d", userID), nil
}

func (m *UserModel) GetUserIdWithFullRefCode(fullRefCode string) (string, error) {
	var userID int
	query := `SELECT user_id FROM "reset_pin" WHERE ref_code = $1`

	err := m.DB.QueryRow(query, fullRefCode).Scan(&userID)
	if err != nil {
		if err == sql.ErrNoRows {
			return "", fmt.Errorf("reference pin not found")
		}
		return "", err
	}

	return fmt.Sprintf("%d", userID), nil
}
