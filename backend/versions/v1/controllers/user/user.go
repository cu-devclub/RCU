package user

import (
	"net/http"
	userService "rcu/versions/v1/services/user"

	"github.com/gin-gonic/gin"
)

type UserController struct {
	Service *userService.UserService
}

func (h *UserController) Hello(c *gin.Context) {
	msg := h.Service.GetMessage()
	c.JSON(http.StatusOK, gin.H{"message": msg})
}

func (h *UserController) Login(c *gin.Context) {
	var loginRequest struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	if err := c.ShouldBindJSON(&loginRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	ret, err := h.Service.Login(loginRequest.Username, loginRequest.Password)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"token":    ret["token"],
		"duration": ret["duration"],
	})
}

func (h *UserController) ForgotPassword(c *gin.Context) {
	ip := c.GetHeader("X-Real-IP")
	if ip == "" {
		ip = c.ClientIP()
	}

	var forgotRequest struct {
		Username string `json:"username"`
	}

	if err := c.ShouldBindJSON(&forgotRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	ref, code, err := h.Service.ForgotPassword(forgotRequest.Username, ip)
	if err != nil {
		c.JSON(code, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"ref_code": ref})
}

func (h *UserController) CheckPin(c *gin.Context) {
	var forgotRequest struct {
		Username string `json:"username"`
		Pin      string `json:"pin"`
		RefCode  string `json:"ref_code"`
	}

	if err := c.ShouldBindJSON(&forgotRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	fullRefCode, code, err := h.Service.CheckPin(forgotRequest.Username, forgotRequest.Pin, forgotRequest.RefCode)
	if err != nil {
		c.JSON(code, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"ref_code": fullRefCode})
}

func (h *UserController) ResetPassword(c *gin.Context) {
	var forgotRequest struct {
		Username    string `json:"username"`
		FullRefCode string `json:"full_ref_code"`
		Newpassword string `json:"password"`
	}

	if err := c.ShouldBindJSON(&forgotRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid input"})
		return
	}

	code, err := h.Service.ResetPassword(forgotRequest.Username, forgotRequest.FullRefCode, forgotRequest.Newpassword)
	if err != nil {
		c.JSON(code, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{})
}
