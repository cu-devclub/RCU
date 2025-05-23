import type { NextApiRequest, NextApiResponse } from 'next'
import { serialize } from 'cookie'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
    if (req.method !== 'POST') {
        return res.status(405).json({ error: 'Method Not Allowed' })
    }

    try {
        const response = await fetch(`${process.env.API_URL}/login`, {
        method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: req.body.username,
                password: req.body.password,
            }),
        })

        if (!response.ok) {
            return res.status(401).json({ success: false, error: 'Unauthorized' })
        }

        const data = await response.json()

        res.setHeader(
            'Set-Cookie',
            serialize('authToken', data["token"], {
                httpOnly: true,
                secure: process.env.NODE_ENV === 'production',
                path: '/',
                sameSite: 'strict',
                maxAge: 60 * 60 * data["duration"],
            })
        )

        return res.status(200).json({ success: true, message: 'Login successful' })
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error' })
    }
}
