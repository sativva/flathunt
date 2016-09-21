// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var client = algoliasearch(ApplicationID, Search-Only-API-Key);
var index = client.initIndex('agencies');
index.search('something', { hitsPerPage: 10, page: 0 })
  .then(function searchDone(content) {
    console.log(content)
  })
  .catch(function searchFailure(err) {
    console.error(err);
  });
