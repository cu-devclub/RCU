package user

import (
	"fmt"
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"golang.org/x/crypto/bcrypt"
)

func (s *UserService) Login(username string, password string) (map[string]interface{}, error) {
	expvar := 72

	user, err := s.Model.Login(username)
	if err != nil {
		return nil, err
	}

	encryptedPass, ok := user["EncryptedPassword"].(string)
	if !ok {
		return nil, fmt.Errorf("invalid encrypted password type")
	}

	err = bcrypt.CompareHashAndPassword([]byte(encryptedPass), []byte(password))
	if err != nil {
		return nil, fmt.Errorf("invalid password")
	}

	claims := jwt.MapClaims{
		"username": username,
		"userID":   user["ID"],
		"exp":      time.Now().Add(time.Hour * time.Duration(expvar)).Unix(),
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	signedToken, err := token.SignedString([]byte(os.Getenv("JWT")))
	if err != nil {
		return nil, err
	}

	res := map[string]interface{}{
		"token":    signedToken,
		"duration": expvar,
	}
	return res, nil
}
