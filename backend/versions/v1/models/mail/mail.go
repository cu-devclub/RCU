package mail

import (
	"crypto/tls"
	"fmt"
	"net"
	"net/smtp"
)

type MailModel struct {
	SMTPHost     string
	SMTPPort     string
	SMTPUsername string
	SMTPPassword string
}

func (m *MailModel) InitSMTP() (*smtp.Client, error) {
	serverAddress := net.JoinHostPort(m.SMTPHost, m.SMTPPort)
	tlsConfig := &tls.Config{
		ServerName: m.SMTPHost,
	}

	conn, err := tls.Dial("tcp", serverAddress, tlsConfig)
	if err != nil {
		return nil, fmt.Errorf("failed to connect to SMTP server: %v", err)
	}

	client, err := smtp.NewClient(conn, m.SMTPHost)
	if err != nil {
		return nil, fmt.Errorf("failed to create SMTP client: %v", err)
	}

	auth := smtp.PlainAuth("", m.SMTPUsername, m.SMTPPassword, m.SMTPHost)
	if err = client.Auth(auth); err != nil {
		return nil, fmt.Errorf("failed to authenticate: %v", err)
	}

	return client, nil
}
