package user

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

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
