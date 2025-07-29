const { IExecuteFunctions } = require('n8n-workflow');
const axios = require('axios');

class TikTokNode {
    constructor() {
        this.description = {
            displayName: 'TikTok',
            name: 'tiktok',
            icon: 'file:tiktok.svg',
            group: ['transform'],
            version: 1,
            description: 'Работа с TikTok API',
            defaults: {
                name: 'TikTok',
            },
            inputs: ['main'],
            outputs: ['main'],
            properties: [
                {
                    displayName: 'Operation',
                    name: 'operation',
                    type: 'options',
                    options: [
                        {
                            name: 'Get User Info',
                            value: 'getUserInfo',
                            description: 'Получить информацию о пользователе',
                        },
                        {
                            name: 'Get Videos',
                            value: 'getVideos',
                            description: 'Получить список видео',
                        },
                        {
                            name: 'Get Video Details',
                            value: 'getVideoDetails',
                            description: 'Получить детали видео',
                        },
                        {
                            name: 'Search Videos',
                            value: 'searchVideos',
                            description: 'Поиск видео',
                        },
                    ],
                    default: 'getUserInfo',
                },
                {
                    displayName: 'User ID',
                    name: 'userId',
                    type: 'string',
                    default: '',
                    displayOptions: {
                        show: {
                            operation: ['getUserInfo', 'getVideos'],
                        },
                    },
                },
                {
                    displayName: 'Video ID',
                    name: 'videoId',
                    type: 'string',
                    default: '',
                    displayOptions: {
                        show: {
                            operation: ['getVideoDetails'],
                        },
                    },
                },
                {
                    displayName: 'Query',
                    name: 'query',
                    type: 'string',
                    default: '',
                    displayOptions: {
                        show: {
                            operation: ['searchVideos'],
                        },
                    },
                },
                {
                    displayName: 'Max Count',
                    name: 'maxCount',
                    type: 'number',
                    default: 10,
                    displayOptions: {
                        show: {
                            operation: ['getVideos', 'searchVideos'],
                        },
                    },
                },
            ],
        };
    }

    async execute(this) {
        const items = this.getInputData();
        const returnData = [];

        for (let i = 0; i < items.length; i++) {
            const operation = this.getNodeParameter('operation', i);
            const accessToken = process.env.TIKTOK_ACCESS_TOKEN;

            if (!accessToken) {
                throw new Error('TikTok Access Token не найден в переменных окружения');
            }

            const headers = {
                'Authorization': `Bearer ${accessToken}`,
                'Content-Type': 'application/json',
            };

            try {
                let response;

                switch (operation) {
                    case 'getUserInfo':
                        const userId = this.getNodeParameter('userId', i);
                        response = await axios.get(`https://api.tiktok.com/v2/user/info/`, {
                            headers,
                            params: {
                                fields: 'open_id,union_id,avatar_url,display_name,bio_description,profile_deep_link,is_verified,follower_count,following_count,likes_count,video_count',
                                user_id: userId,
                            },
                        });
                        break;

                    case 'getVideos':
                        const videoUserId = this.getNodeParameter('userId', i);
                        const maxCount = this.getNodeParameter('maxCount', i);
                        response = await axios.get(`https://api.tiktok.com/v2/video/list/`, {
                            headers,
                            params: {
                                fields: 'id,title,cover_image_url,video_description,create_time,share_url,statistics',
                                user_id: videoUserId,
                                max_count: maxCount,
                            },
                        });
                        break;

                    case 'getVideoDetails':
                        const videoId = this.getNodeParameter('videoId', i);
                        response = await axios.get(`https://api.tiktok.com/v2/video/query/`, {
                            headers,
                            params: {
                                fields: 'id,title,cover_image_url,video_description,create_time,share_url,statistics,music,author',
                                video_id: videoId,
                            },
                        });
                        break;

                    case 'searchVideos':
                        const query = this.getNodeParameter('query', i);
                        const searchMaxCount = this.getNodeParameter('maxCount', i);
                        response = await axios.get(`https://api.tiktok.com/v2/video/search/`, {
                            headers,
                            params: {
                                fields: 'id,title,cover_image_url,video_description,create_time,share_url,statistics',
                                query,
                                max_count: searchMaxCount,
                            },
                        });
                        break;

                    default:
                        throw new Error(`Неизвестная операция: ${operation}`);
                }

                returnData.push({
                    json: response.data,
                });

            } catch (error) {
                if (this.continueOnFail()) {
                    returnData.push({
                        json: {
                            error: error.message,
                            operation,
                        },
                    });
                    continue;
                }
                throw error;
            }
        }

        return [returnData];
    }
}

module.exports = { TikTokNode }; 