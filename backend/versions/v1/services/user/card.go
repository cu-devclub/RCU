package user

import (
	"fmt"
	"image"
	"image/draw"
	"net/http"
	"os"

	"github.com/fogleman/gg"
	"github.com/nfnt/resize"
	"github.com/skip2/go-qrcode"
)

func FillBoxCover(src image.Image, targetW, targetH uint) image.Image {
	srcW := src.Bounds().Dx()
	srcH := src.Bounds().Dy()

	scaleW := float64(targetW) / float64(srcW)
	scaleH := float64(targetH) / float64(srcH)
	scale := scaleW
	if scaleH > scaleW {
		scale = scaleH
	}

	newW := uint(float64(srcW) * scale)
	newH := uint(float64(srcH) * scale)

	scaled := resize.Resize(newW, newH, src, resize.Lanczos3)

	startX := int((int(newW) - int(targetW)) / 2)
	startY := int((int(newH) - int(targetH)) / 2)

	cropRect := image.Rect(0, 0, int(targetW), int(targetH))
	cropped := image.NewRGBA(cropRect)
	draw.Draw(cropped, cropRect, scaled, image.Point{X: startX, Y: startY}, draw.Src)

	return cropped
}

func setFontFace(dc *gg.Context, font string, size float64) {
	if err := dc.LoadFontFace(font, size); err != nil {
		panic(err)
	}
}

func (s *UserService) Card(userId string) (*gg.Context, error) {
	thaiFont := "./files/NotoSansThai.ttf"
	chulaFont := "./files/ChulaCharasNewReg.ttf"

	const width = 1011
	const height = 638

	dc := gg.NewContext(width, height)
	dc.SetRGB(1, 1, 1)
	dc.Clear()

	dc.SetHexColor("#aa44fe")
	dc.DrawRectangle(width-30, 0, 30, height)
	dc.Fill()

	setFontFace(dc, thaiFont, 20)

	resp, err := http.Get("https://rcuchula.com/student_picture/2566/6634473123.jpg")
	if err != nil {
		return nil, fmt.Errorf("Failed to load image: %v", err)
	}
	defer resp.Body.Close()

	img, _, err := image.Decode(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("Failed to decode image: %v", err)
	}
	resizeImg := FillBoxCover(img, 160, 200)
	dc.DrawImage(resizeImg, width-160-80, 95)

	dc.SetRGB(0, 0, 0)
	dc.DrawStringWrapped("บัตรประจำตัวนิสิตหอพัก", width-80-80, 65, 0.5, 0.5, float64(width)-20, 1.5, gg.AlignCenter)

	file, err := os.Open("./files/logo.jpg")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	img, _, err = image.Decode(file)
	if err != nil {
		panic(err)
	}

	resizeImg = FillBoxCover(img, 160, 160)
	dc.DrawImage(resizeImg, 30, 50)

	dc.SetHexColor("#3d3d3d")
	setFontFace(dc, thaiFont, 30)
	dc.DrawString("หอพักนิสิตจุฬาลงกรณ์มหาวิทยาลัย", 220, 80)
	setFontFace(dc, chulaFont, 30)
	dc.DrawString("Residence of chulalongkorn university", 220, 120)

	dc.SetHexColor("#000000")
	setFontFace(dc, thaiFont, 25)
	dc.DrawString("สิทธา ดาราพิสุทธิ์", 240, 180)
	dc.DrawString("Sittha Darapisut", 240, 220)
	dc.DrawString("เลขประจำตัวนิสิต 6634473123", 240, 260)
	dc.DrawString("คณะ วิทยาศาสตร์", 240, 300)
	dc.DrawString("วันที่ออกบัตร: 01/07/2567  วันหมดอายุ: 31/5/2568", 240, 340)
	// dc.DrawString("ตึก จำปี 1417-A", 240, 340)
	// dc.DrawString("วันที่ออกบัตร: 01/07/2567  วันหมดอายุ: 31/5/2568", 240, 380)

	qr, err := qrcode.New("6634473123", qrcode.Medium)
	if err != nil {
		panic(err)
	}

	qr.DisableBorder = true
	img = qr.Image(160)
	dc.DrawImage(img, width-160-80, 430)

	file, err = os.Open("./files/signature.jpg")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	img, _, err = image.Decode(file)
	if err != nil {
		panic(err)
	}

	resizeImg = FillBoxCover(img, uint(img.Bounds().Dx())/6, uint(img.Bounds().Dy())/6)
	dc.DrawImage(resizeImg, (width-resizeImg.Bounds().Dx())/2, 450)

	dc.SetHexColor("#000000")
	dc.DrawRectangle(float64(((width-resizeImg.Bounds().Dx())/2)-10), float64(450+(resizeImg.Bounds().Dy())+10), float64(resizeImg.Bounds().Dx()+20), 2)
	dc.Fill()

	dc.SetRGB(0, 0, 0)
	dc.DrawStringWrapped("อนุสาสกหอพักนิสิต", float64(width/2), float64(450+(resizeImg.Bounds().Dy())+10+3+30), 0.5, 0.5, float64(width)-20, 1.5, gg.AlignCenter)

	dc.DrawStringWrapped("ตึก", 120, height-170, 0.5, 0.5, float64(width)-20, 1.5, gg.AlignCenter)
	dc.DrawStringWrapped("จำปี", 120, height-120, 0.5, 0.5, float64(width)-20, 1.5, gg.AlignCenter)
	dc.DrawStringWrapped("1417-A", 120, height-90, 0.5, 0.5, float64(width)-20, 1.5, gg.AlignCenter)

	return dc, nil
}
