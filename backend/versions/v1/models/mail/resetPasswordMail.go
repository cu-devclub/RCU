package mail

import (
	"fmt"
	"log"
	"time"
)

func (m *MailModel) SendResetPasswordMail(targetMail string, pin string, ip string, refCode string) error {
	client, err := m.InitSMTP()
	if err != nil {
		log.Fatalf("Failed to initialize SMTP client: %v", err)
	}

	now := time.Now()
	formattedTime := now.Format("2006-01-02 15:04:05")
	subject := fmt.Sprintf("[หอพักนิสิตจุฬาฯ] คำขอรีเซ็ตรหัสผ่านจาก IP %s - %s (UTC+7)", ip, formattedTime)
	htmlBody := `<html>
<head>
  <meta charset="UTF-8">
  <title>รีเซ็ตรหัสผ่าน</title>
</head>
<body style="margin:0; padding:0; font-family:Arial, sans-serif; background-color:#F8E1EA;">
<div style="padding:24px 16px 24px 16px;display: block;">
  <table align="center" width="100%" cellpadding="0" cellspacing="0" style="max-width:600px; margin:auto; background-color:#ffffff; border-radius:6px; overflow:hidden;">
    <tr style="background-color:#DE5C8E;">
      <td align="center" style="padding:20px;">
        <img src="https://scontent.fbkk23-1.fna.fbcdn.net/v/t39.30808-6/308340267_550481833548076_4816808473116244269_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeEUbQn_Ldvr0JMBJ51AguYmTxSMOI2D3xJPFIw4jYPfEkX1XR5PMj7glohi8EXWRdA1gOSXJE_86O-IT77ZB4zV&_nc_ohc=S8Svs0BOjr0Q7kNvwFMmJkY&_nc_oc=AdkZnmf5IM1H0Fc0e04cJq-iwSR8zbUWrD0_8a_G-9My2lv4R5s-IYssPh-cLA7NOxKnZhw5S9o2iUpunLdNuTdp&_nc_zt=23&_nc_ht=scontent.fbkk23-1.fna&_nc_gid=bPWl1dIU7fFGa3LrwWNnMA&oh=00_AfKaWRJwxxTdey4TMLqAmH7zKgZ_8RT1IHKAUj26tN1mXw&oe=68323E0A" alt="Logo" style="height:100px;border-radius:50%; margin-bottom:10px;">
      </td>
    </tr>
    <tr>
      <td style="padding:30px;">
        <h2 style="color:#1b1f2a; margin-top:0;">รีเซ็ตรหัสผ่าน</h2>
        <p>คุณได้ทำการขอรีเซ็ตรหัสผ่าน<br>
        ใช้รหัสแบบใช้ครั้งเดียว (OTP) ข้างล่างเพื่อยืนยันตัวตน:</p>

        <p style="font-size:28px; font-weight:bold; letter-spacing:2px; color:#1b1f2a;">` + pin + `</p>

		<p style="color:#999;">Ref: ` + refCode + `</p>
        <p style="color:#333;">รหัสแบบใช้ครั้งเดียว (OTP) จะมีอายุเพียง 15 นาทีเท่านั้น<br>ห้ามเปิดเผยรหัสให้ผู้อื่นรับรู้โดยเด็ดขาด</p>

        <p>หากคุณไม่ได้ได้ทำการร้องขอกรุณาติดต่อ<br>
		<strong>สำนักงานหอพักนิสิตจุฬาลงกรณ์มหาวิทยาลัย</strong></p>
		
        <p style="font-size:12px; color:#999; margin-top:40px;">
          สำนักงานหอพักนิสิตจุฬาลงกรณ์มหาวิทยาลัย<br>
          นี่เป็นข้อความอัตโนมัติ โปรดอย่าตอบกลับ
        </p>
      </td>
    </tr>
  </table>
  </div>
</body>
</html>`

	msg := []byte("To: " + targetMail + "\r\n" +
		"Subject: " + subject + "\r\n" +
		"MIME-Version: 1.0\r\n" +
		"Content-Type: text/html; charset=\"UTF-8\"\r\n" +
		"\r\n" +
		htmlBody + "\r\n")

	if err = client.Mail(m.SMTPUsername); err != nil {
		log.Fatalf("Failed to set from: %v", err)
	}
	if err = client.Rcpt(targetMail); err != nil {
		log.Fatalf("Failed to set to: %v", err)
	}

	writer, err := client.Data()
	if err != nil {
		log.Fatalf("Failed to write data: %v", err)
	}

	_, err = writer.Write(msg)
	if err != nil {
		log.Fatalf("Failed to send message: %v", err)
	}

	err = writer.Close()
	if err != nil {
		log.Fatalf("Failed to close writer: %v", err)
	}

	client.Quit()

	return nil
}
