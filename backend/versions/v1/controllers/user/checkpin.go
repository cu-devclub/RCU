package user

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

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
