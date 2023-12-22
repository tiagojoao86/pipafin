export abstract class BaseDataManger {
  baseUrl: string = 'http://localhost:3000/api/';

  readonly METHODS = {
    GET: 'GET',
    POST: 'POST',
    PUT: 'PUT',
    DELETE: 'DELETE',
    PATCH: 'PATCH',
  };

  constructor() {}

  public getJson(url: string, options: any) {
    return fetch(url, options).then((response) => {
      if (response.ok && response.status === 200) return response.json();
      else throw this.getExceptionFromResponse(response);
    });
  }

  private getExceptionFromResponse(response: Response) {
    new Error(`Status: ${response.status} on url: ${response.url}`);
  }
}
