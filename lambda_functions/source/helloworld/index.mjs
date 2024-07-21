export const handler = async (event) => {
  const message = 'Hello World!';
  console.log(message);

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      message: message,
    })
  };
  return response;
}
