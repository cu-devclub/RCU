import type { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Method Not Allowed' })
    }

    try {
        const response = await fetch(`${process.env.API_URL}/forgot-password`, {
        method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: req.body.username,
            }),
        })

        if (response.status === 401) {
            return res.status(401).json({ success: false, msg: 'ไม่พบชื่อผู้ใช้งานนี้' })
        }

        const data = await response.json()

        if (response.status === 500) {
            return res.status(500).json({ success: false, msg: 'ระบบขัดข้อง', error: data.error })
        }

        return res.status(200).json({ success: true, ref_code: data.ref_code })
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error' })
    }
}