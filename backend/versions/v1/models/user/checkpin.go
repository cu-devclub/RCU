package user

import (
	"database/sql"
	"fmt"
	"time"
)

func (m *UserModel) CheckPin(userId string, refCode string) (string, string, time.Time, error) {
	var fullRefCode string
	var pin string
	var datetime time.Time

	query := `SELECT ref_code, pin, created_at FROM "reset_pin" WHERE "ref_code"::text LIKE '%' || $1 AND user_id=$2;`

	err := m.DB.QueryRow(query, refCode, userId).Scan(&fullRefCode, &pin, &datetime)
	if err != nil {
		if err == sql.ErrNoRows {
			return "", "", time.Time{}, fmt.Errorf("reset pin not found")
		}
		return "", "", time.Time{}, err
	}

	return fullRefCode, pin, datetime, nil
}
