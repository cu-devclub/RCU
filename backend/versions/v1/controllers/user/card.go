package user

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func (h *UserController) Card(c *gin.Context) {
	// authToken, err := c.Cookie("authToken")
	// if err != nil {
	// 	c.String(http.StatusUnauthorized, "Missing auth token")
	// 	return
	// }

	// jwtKey := os.Getenv("JWT")
	// if jwtKey == "" {
	// 	c.String(http.StatusInternalServerError, "JWT key not set")
	// 	return
	// }

	// token, err := jwt.Parse(authToken, func(token *jwt.Token) (interface{}, error) {
	// 	// Validate the alg is what you expect:
	// 	if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
	// 		return nil, jwt.ErrSignatureInvalid
	// 	}
	// 	return []byte(jwtKey), nil
	// })

	// if err != nil || !token.Valid {
	// 	c.String(http.StatusUnauthorized, "Invalid auth token")
	// 	return
	// }

	// claims, ok := token.Claims.(jwt.MapClaims)
	// if !ok {
	// 	c.String(http.StatusUnauthorized, "Invalid token claims")
	// 	return
	// }

	// var userID string
	// switch v := claims["userID"].(type) {
	// case string:
	// 	userID = v
	// case float64:
	// 	userID = fmt.Sprintf("%.0f", v)
	// default:
	// 	c.String(http.StatusUnauthorized, "userID not found in token")
	// 	return
	// }

	// php 5.6

	dc, err := h.Service.Card("1")
	if err != nil {
		c.String(http.StatusUnauthorized, err.Error())
		return
	}

	c.Header("Content-Type", "image/png")
	dc.EncodePNG(c.Writer)
}
