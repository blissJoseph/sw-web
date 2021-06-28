var express = require('express');
var router = express.Router();
var mysql = require('mysql2/promise')

const db_config = {
  host: 'db',
  user:'root',
  password: 'a1234567',
  database: 'db',
  port: 3306,
}

/* GET home page. */
router.get('/model_list', async function(req, res, next) {
  try {
    const {} = req.query
    const connection =  await mysql.createConnection(db_config)
    await connection.connect()
    const modelList = (await connection.query(`
    SELECT * from db.model
    `))[0]
    await connection.end()
    res.json({ modelList })
  } catch(e) {
    console.log(e)
  }
});

router.get('/model_info', async function(req, res) {
  try {
    const modelName = req.query.modelName
    const _ = req.query
    const connection =  await mysql.createConnection(db_config)
    await connection.connect()

    const elementList = (await connection.query(`
    SELECT 
      element_name as name 
    FROM db.model_element me 
    INNER JOIN db.element e 
      ON e.name = me.element_name    
    WHERE me.name= ?`,[modelName]))[0]
    
    const toolList = (await connection.query(`
    SELECT
      tool_type as type, 
      tool_name as name 
    FROM db.model_tool mt 
    INNER JOIN db.tool t 
      ON t.name = mt.tool_name AND t.type = mt.tool_type    
    WHERE mt.name= ?`,[modelName]))[0]

    const processingList = (await connection.query(`
    SELECT
      processing_type as type, 
      processing_name as name 
    FROM db.model_processing mp 
    INNER JOIN db.processing p 
      ON p.name = mp.processing_name AND p.type = mp.processing_type    
    WHERE mp.name= ?`,[modelName]))[0]

    const drawingList = (await connection.query(`
    SELECT
      *
    FROM db.model_drawing md
    WHERE model_name = ?
    `, [modelName]))[0]

    const groupedToolList = {
      '종류' : [],
      '소재' : [],
      '날수' : [],
    }
    for(const item of toolList) {
      if(groupedToolList[item.type]) {
        groupedToolList[item.type].push(item)
      } else {
        groupedToolList[item.type] = [item]
      }
    }
    const groupedProcessingList = {
      'X': [],
      'Y': [],
      'Z': [],
    }
    for(const item of processingList) {
      if(groupedProcessingList[item.type]) {
        groupedProcessingList[item.type].push(item)
      } else {
        groupedProcessingList[item.type] = [item]
      }
    }
    await connection.end()
    res.json({ elementList, toolList: groupedToolList, processingList: groupedProcessingList, drawingList })
  } catch(e) {
    console.log(e)
  }
});

router.get('/calculate', async function(req, res) {
  try {
    const _ = req.query
    const id = `$원소재:${_.element}$공구:#종류:${_.tool1}#소재:${_.tool2}#날수:${_.tool3}#공구경:${_.tool4}$설비명:#X:${_.processing1}#Y:${_.processing2}#Z:${_.processing3}#R:${_.processing4}`
    const connection =  await mysql.createConnection(db_config)
    await connection.connect()
    const result = (await connection.query(`
    SELECT
      * 
    FROM db.result    
    WHERE id= ?`,[id]))
    await connection.end()
    if(result[0].length){
      res.json(result[0])
    } else {
      console.log('결과없음')
      res.json(null)
    }
  } catch(e) {
    console.log(e)
  }
})
module.exports = router;
