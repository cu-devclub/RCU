package parcel

import (
	parcelModel "rcu/versions/v1/models/parcel"
)

func (ps *ParcelService) Get(userID string, isWaiting bool) ([]*parcelModel.Parcel, error) {
	var parcels []parcelModel.Parcel
	var err error
	if isWaiting {
		parcels, err = ps.Model.GetWaiting(userID)
	} else {
		parcels, err = ps.Model.GetAll(userID)
	}

	if err != nil {
		return nil, err
	}
	ptrParcels := make([]*parcelModel.Parcel, len(parcels))
	for i := range parcels {
		ptrParcels[i] = &parcels[i]
	}
	return ptrParcels, nil
}
