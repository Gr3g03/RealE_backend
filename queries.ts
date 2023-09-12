import Database from "better-sqlite3";

const db = new Database('./data.db', {
    verbose: console.log
})

export const getQueryById = (tableName : string) => db.prepare(`
SELECT * FROM ${tableName} WHERE id=?;`)
