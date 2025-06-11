package parcel

func (pm *ParcelModel) GetWaiting(userID string) ([]Parcel, error) {
	rows, err := pm.DB.Query(`
		SELECT id, user_id, parcel_number, type, state, created_at
		FROM parcel
		WHERE user_id = $1 AND state = $2
	`, userID, "รอรับ")
	if err != nil {
		return []Parcel{}, err
	}
	defer rows.Close()

	var parcels []Parcel

	for rows.Next() {
		var p Parcel
		err := rows.Scan(&p.ID, &p.UserID, &p.ParcelNumber, &p.Type, &p.State, &p.CreatedAt)
		if err != nil {
			return []Parcel{}, err
		}
		parcels = append(parcels, p)
	}

	return parcels, nil
}
