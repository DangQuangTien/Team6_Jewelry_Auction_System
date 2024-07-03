




$(document).ready(function(){
    $('#detailModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var photo = button.data('photo');
        var name = button.data('name');
        var artist = button.data('artist');
        var circa = button.data('circa');
        var material = button.data('material');
        var dial = button.data('dial');
        var braceletMaterial = button.data('braceletmaterial');
        var caseDimensions = button.data('casedimensions');
        var braceletSize = button.data('braceletsize');
        var serialNumber = button.data('serialnumber');
        var referenceNumber = button.data('referencenumber');
        var caliber = button.data('caliber');
        var movement = button.data('movement');
        var condition = button.data('condition');
        var metal = button.data('metal');
        var gemstones = button.data('gemstones');
        var measurements = button.data('measurements');
        var weight = button.data('weight');
        var stamped = button.data('stamped');
        var ringSize = button.data('ringsize');
        var finalPrice = button.data('finalprice');
        
        var modal = $(this);
        modal.find('#modal-photo').attr('src', photo);
        modal.find('#modal-name').text(name);
        modal.find('#modal-artist').text(artist);
        modal.find('#modal-circa').text(circa);
        modal.find('#modal-material').text(material);
        modal.find('#modal-dial').text(dial);
        modal.find('#modal-braceletmaterial').text(braceletMaterial);
        modal.find('#modal-casedimensions').text(caseDimensions);
        modal.find('#modal-braceletsize').text(braceletSize);
        modal.find('#modal-serialnumber').text(serialNumber);
        modal.find('#modal-referencenumber').text(referenceNumber);
        modal.find('#modal-caliber').text(caliber);
        modal.find('#modal-movement').text(movement);
        modal.find('#modal-condition').text(condition);
        modal.find('#modal-metal').text(metal);
        modal.find('#modal-gemstones').text(gemstones);
        modal.find('#modal-measurements').text(measurements);
        modal.find('#modal-weight').text(weight);
        modal.find('#modal-stamped').text(stamped);
        modal.find('#modal-ringsize').text(ringSize);
        modal.find('#modal-finalprice').text(finalPrice);
    });
});
