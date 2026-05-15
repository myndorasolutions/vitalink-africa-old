package response

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type ErrorBody struct {
	Error   string `json:"error"`
	Code    string `json:"code"`
	Details any    `json:"details,omitempty"`
}

func OK(c *gin.Context, data any) {
	c.JSON(http.StatusOK, data)
}

func Created(c *gin.Context, data any) {
	c.JSON(http.StatusCreated, data)
}

func BadRequest(c *gin.Context, code, msg string) {
	c.JSON(http.StatusBadRequest, ErrorBody{Error: msg, Code: code})
}

func Unauthorized(c *gin.Context, msg string) {
	c.JSON(http.StatusUnauthorized, ErrorBody{Error: msg, Code: "unauthorized"})
}

func Forbidden(c *gin.Context, msg string) {
	c.JSON(http.StatusForbidden, ErrorBody{Error: msg, Code: "forbidden"})
}

func NotFound(c *gin.Context, msg string) {
	c.JSON(http.StatusNotFound, ErrorBody{Error: msg, Code: "not_found"})
}

func Internal(c *gin.Context, msg string) {
	c.JSON(http.StatusInternalServerError, ErrorBody{Error: msg, Code: "internal_error"})
}
