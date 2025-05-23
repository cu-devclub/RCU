package user

import (
	"database/sql"
	"fmt"
)

type User struct {
	ID       int
	Username string
	Password string
}

func (m *UserModel) Login(username string) (map[string]interface{}, error) {
	query := `SELECT id, username, password FROM "user" WHERE username = $1`

	var u User
	err := m.DB.QueryRow(query, username).Scan(&u.ID, &u.Username, &u.Password)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("user not found")
		}
		return nil, err
	}

	return map[string]interface{}{
		"ID":                u.ID,
		"Username":          u.Username,
		"EncryptedPassword": u.Password,
	}, nil
}
