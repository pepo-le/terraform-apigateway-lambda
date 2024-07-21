import { DynamoDBClient, PutItemCommand } from "@aws-sdk/client-dynamodb";
import { marshall } from '@aws-sdk/util-dynamodb'

const config = {
  region: 'us-east-1', // 使用するリージョンを指定
}

const dynamodb = new DynamoDBClient(config);

// 新しいデータを追加する関数
async function putData(id, timestamp) {
  console.log('put: ', id, timestamp);
  const input = {
    id: id,
    timestamp: timestamp
  }

  const params = {
    TableName: 'foo-table',
    Item: marshall(input)
  };

  try {
    const command = new PutItemCommand(params);
    await dynamodb.send(command);
    console.log(`Data added to foo-table: id=${id}, timestamp=${timestamp}`);
  } catch (error) {
    console.error('Error adding data to foo-table:', error);
  }
}

// Lambda handler 関数
export const handler = async (event, context) => {
  const request = JSON.parse(JSON.stringify(event));
  const body = JSON.parse(request.body);
  const id = body.id;
  const timestamp = body.timestamp;

  await putData(id, timestamp);

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Data added to foo-table',
    }),
  };

  return response;
};
