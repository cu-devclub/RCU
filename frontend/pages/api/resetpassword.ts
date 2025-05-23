import type { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Method Not Allowed' })
    }

    try {
        const response = await fetch(`${process.env.API_URL}/reset-password`, {
        method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: req.body.username,
                full_ref_code: req.body.full_ref_code,
                password: req.body.password,
            }),
        })
        
        const data = await response.json()

        if (response.status === 401) {
            return res.status(401).json({ success: false, msg: data.error })
        }

        if (response.status === 500) {
            return res.status(500).json({ success: false, msg: 'ระบบขัดข้อง', error: data })
        }

        return res.status(200).json({ success: true})
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error' })
    }
}