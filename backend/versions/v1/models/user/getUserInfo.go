package user

import (
	"database/sql"
	"fmt"
)

func (m *UserModel) GetUserEMail(userID string) (string, error) {
	var email string
	query := `SELECT content FROM contact WHERE user_id=$1 AND type='EMAIL' limit 1`

	err := m.DB.QueryRow(query, userID).Scan(&email)
	if err != nil {
		if err == sql.ErrNoRows {
			return "", fmt.Errorf("user not found")
		}
		return "", err
	}

	return email, nil
}
