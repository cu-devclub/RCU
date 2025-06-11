package parcel

import (
	parcelService "rcu/versions/v1/services/parcel"
)

type ParcelController struct {
	Service *parcelService.ParcelService
}
