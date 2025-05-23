package user

import (
	"fmt"
)

func (m *UserModel) InsertResetPin(userId string, pin string) (string, error) {

	var refCode string
	query := `
		INSERT INTO reset_pin (user_id, pin, created_at)
		VALUES ($1, $2, CURRENT_TIMESTAMP)
		RETURNING ref_code;
	`
	err := m.DB.QueryRow(query, userId, pin).Scan(&refCode)
	if err != nil {
		return "", fmt.Errorf("failed to insert reset_pin: %v", err)
	}

	return refCode, nil
}
