export abstract class BaseDataManger {
  baseUrl: string = 'http://localhost:3000/api/';

  constructor() {}

  public getJson(url: string) {
    return fetch(url).then((response) => {
      if (response.ok && response.status === 200) return response.json();
      else throw this.getExceptionFromResponse(response);
    });
  }

  private getExceptionFromResponse(response: Response) {
    new Error(`Status: ${response.status} on url: ${response.url}`);
  }
}
