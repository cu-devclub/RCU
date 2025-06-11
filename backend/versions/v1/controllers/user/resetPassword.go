package user

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

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
