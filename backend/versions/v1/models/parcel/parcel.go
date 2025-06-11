package parcel

import "database/sql"

type ParcelModel struct {
	DB *sql.DB
}

type Parcel struct {
	ID           int
	UserID       int
	ParcelNumber string
	Type         string
	State        string
	CreatedAt    sql.NullTime
}
