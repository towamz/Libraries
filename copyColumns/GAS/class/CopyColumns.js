class CopyColumns{
  /**
   * 指定された列をデータ用シートから結果用シートへコピーします
   * 
   * 
   * @param {string|number} shIdNameOrig - データ用シート名またはシートID
   * @param {string} shNameDest - 結果用シート名(シート新規追加)(既定値:'結果')
   * @param {number} ssIdOrig - データ用スプレッドシートID(既定値:このスプレッドシート)
   * @param {number} ssIdDest - 結果用スプレッドシートID(既定値:このスプレッドシート)
   */
  constructor(shIdNameOrig, shNameDest = '結果',ssIdOrig = -1,ssIdDest = -1) {
    let ssOrig;
    let ssDest;

    // スプレッドシート取得
    if(ssIdOrig == -1){
      ssOrig = SpreadsheetApp.getActiveSpreadsheet();
    }else{
      ssOrig = SpreadsheetApp.openById(ssIdOrig);
    }

    if(ssIdDest == -1){
      ssDest = SpreadsheetApp.getActiveSpreadsheet();
    }else{
      ssDest = SpreadsheetApp.openById(ssIdDest);   
    }

    // データシート取得
    if(typeof shIdNameOrig === 'number') {
      this._shOrig = ssOrig.getSheetById(shIdNameOrig);
    } else {
      this._shOrig = ssOrig.getSheetByName(shIdNameOrig);
    }

    // 結果シート生成
    if(ssDest.getSheetByName(shNameDest)){
      let dateTime = Utilities.formatDate(new Date(), "Asia/Tokyo", "yyMMdd-HHmmss");
      this._shDest = ssDest.insertSheet(shNameDest + dateTime);
    }else{
      this._shDest = ssDest.insertSheet(shNameDest);
    }

    this._targetColumns = []; //要素なしの配列を宣言
  }


  // setter/getter
  set targetColumns(columnStr) {
    // 列名の有効性確認(エラーハンドルなし、プログラムを止める)
    // 列記号(アルファベット)から列番号に変換して格納する
    let colNum = this._shOrig.getRange(columnStr + "1").getColumn();
    this._targetColumns.push(colNum);
  }

  get targetColumns() {
    // 列番号を列記号(アルファベット)に変換して返す
    let targetColumnsStr = this._targetColumns.map((columnNum) => {
      return this._shOrig.getRange(1, columnNum).getA1Notation().replace(/[0-9]/g, '');
    });
    return targetColumnsStr;
  }


  // メソッド
  copyColumns(){
    for (var i = 0; i < this._targetColumns.length; i++) {
      let colData = this._shOrig.getRange(1,this._targetColumns[i],this._shOrig.getMaxRows(),1).getValues();
      this._shDest.getRange(1,i+1,colData.length,1).setValues(colData);
    }
  }
}
