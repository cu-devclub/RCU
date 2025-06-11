package parcel

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

func (pc *ParcelController) Get(c *gin.Context) {
	authToken, err := c.Cookie("authToken")
	if err != nil {
		c.String(http.StatusUnauthorized, "Missing auth token")
		return
	}

	jwtKey := os.Getenv("JWT")
	if jwtKey == "" {
		c.String(http.StatusInternalServerError, "JWT key not set")
		return
	}

	token, err := jwt.Parse(authToken, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, jwt.ErrSignatureInvalid
		}
		return []byte(jwtKey), nil
	})

	if err != nil || !token.Valid {
		c.String(http.StatusUnauthorized, "Invalid auth token")
		return
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		c.String(http.StatusUnauthorized, "Invalid token claims")
		return
	}

	var userID string
	switch v := claims["userID"].(type) {
	case string:
		userID = v
	case float64:
		userID = fmt.Sprintf("%.0f", v)
	default:
		c.String(http.StatusUnauthorized, "userID not found in token")
		return
	}

	state := c.Query("state")
	if state == "waiting" {
		parcel, err := pc.Service.Get(userID, true)
		if err != nil {
			c.String(http.StatusInternalServerError, "Failed to get parcel: %v", err)
			return
		}
		c.JSON(http.StatusOK, parcel)
		return
	}

	parcel, err := pc.Service.Get(userID, false)
	if err != nil {
		c.String(http.StatusInternalServerError, "Failed to get parcel: %v", err)
		return
	}
	c.JSON(http.StatusOK, parcel)
}
