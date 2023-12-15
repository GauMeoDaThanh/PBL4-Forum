// Api getallProvince
const host = "https://provinces.open-api.vn/api/";
var callAPI = (api) => {
    return axios.get(api)
        .then((response) => {
            renderData(response.data, "select-from-location");
            renderData(response.data,"select-to-location");
        });
}
callAPI('https://provinces.open-api.vn/api/?depth=1');
var callApiDistrict = (api) => {
    return axios.get(api)
        .then((response) => {
            renderData(response.data.districts, "district");
        });
}
var callApiWard = (api) => {
    return axios.get(api)
        .then((response) => {
            renderData(response.data.wards, "ward");
        });
}
var renderData = (array, select) => {
    let row = '';

    // Thêm thuộc tính 'selected' vào thẻ option đầu tiên
    row += `<option value="${array[0].name}" selected>${array[0].name}</option>`;

    // Tiếp tục vòng lặp để thêm các option khác
    for (let i = 1; i < array.length; i++) {
        row += `<option value="${array[i].name}">${array[i].name}</option>`;
    }

    document.querySelector("#" + select).innerHTML = row;
}
function getProvinceOption(idFrom,valueFrom,idTo,valueTo) {
    var selectElement = document.getElementById(idFrom);
    var selectElement2 = document.getElementById(idTo);
    selectElement.value=valueFrom
    selectElement2.value=valueTo
    console.log(selectElement.value)
    console.log(selectElement2.value)
}