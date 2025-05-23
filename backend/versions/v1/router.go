package v1

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	userController "rcu/versions/v1/controllers/user"
	mailModel "rcu/versions/v1/models/mail"
	userModel "rcu/versions/v1/models/user"
	userService "rcu/versions/v1/services/user"

	_ "github.com/lib/pq"

	"github.com/gin-gonic/gin"
)

var db *sql.DB

func initDB() *sql.DB {
	connStr := fmt.Sprintf(
		"host=%s port=%s user=%s password=%s dbname=%s sslmode=disable",
		os.Getenv("DB_HOST"), os.Getenv("DB_PORT"),
		os.Getenv("DB_USER"), os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_NAME"),
	)
	database, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Cannot open DB: %v", err)
	}
	if err := database.Ping(); err != nil {
		log.Fatalf("Cannot connect to DB: %v", err)
	}
	return database
}

func RegisterRoutes(r *gin.RouterGroup) {
	db = initDB()

	MailModel := &mailModel.MailModel{
		SMTPHost:     os.Getenv("SMTP_HOST"),
		SMTPPort:     os.Getenv("SMTP_PORT"),
		SMTPUsername: os.Getenv("SMTP_USERNAME"),
		SMTPPassword: os.Getenv("SMTP_PASSWORD"),
	}

	userModel := &userModel.UserModel{DB: db}
	userService := &userService.UserService{Model: userModel, MailModel: MailModel}
	userController := &userController.UserController{Service: userService}

	r.GET("/hello", userController.Hello)
	r.POST("/login", userController.Login)
	r.POST("/forgot-password", userController.ForgotPassword)
	r.POST("/checkpin", userController.CheckPin)
	r.POST("/reset-password", userController.ResetPassword)
}
