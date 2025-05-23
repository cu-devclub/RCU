package user

func (m *UserModel) UpdatePassword(userId string, hashedPassword string) error {
	query := `UPDATE "user" SET password = $1 WHERE id = $2`

	_, err := m.DB.Exec(query, hashedPassword, userId)
	if err != nil {
		return err
	}
	return nil
}
