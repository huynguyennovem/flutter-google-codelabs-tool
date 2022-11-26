1. Assume that you already have a Google Form with some basic info and need to have an input field for attendees' Profile Cloud Skill Boots, eg: [https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939](https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939)

2. From Responses Tab in Google Forms, export a Google Sheet file (for eg: https://docs.google.com/spreadsheets/d/1bzuFEiI9Sh3fT_nY84b2JdTqzhpVHkU00VKsVhKOr4U/edit?usp=sharing):

3. Init a project in [Google Apps Script](https://script.google.com/home) and use below sample code (replacing ID in `openById` by your own Google Sheet file ID):

   ```
      function doGet(request) {
        var sheet = SpreadsheetApp.openById("1bzuFEiI9Sh3fT_nY84b2JdTqzhpVHkU00VKsVhKOr4U");
        var values = sheet.getActiveSheet().getDataRange().getValues();
        var data = [];
        for (var i = 1; i < values.length; i++) {
          var row = values[i];
          var datas = {};
          datas['Timestamp'] = row[0];
          datas['Your email'] = row[1];
          datas['Joined codelab'] = row[2];
          datas['How to get a certificate'] = row[3];
          datas['Link public profile'] = row[4];
          data.push(datas);
        }
        return ContentService.createTextOutput(JSON.stringify(data)).setMimeType(ContentService.MimeType.JSON);
      }
   ```

4. **Deploy** it as Web app. 

5. After the deployment succeeds, **Copy** Web app URL to use later in Final result page.
You can try opening it in the browser to check, it's JSON format. 