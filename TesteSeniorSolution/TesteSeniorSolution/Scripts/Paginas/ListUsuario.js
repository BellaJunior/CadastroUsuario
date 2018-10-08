//Deve ter a URL da aplicação
var UrlAplicacao = ""

function LoadPage() {

}

function ComandosTela() {
    $("#btn_buscar").click(function () {
        //Click do Buscar
        $.ajax({
            url: UrlAplicacao + '/ListUsuario/ListaUsuario',
            async: true,
            type: "GET",
            dataType: 'json',
            data: {
                cd_id_usuario: $("#m_id_usuario").val()
            },
            success: function (response) {
                $(response).each(function (i, param) {
                    $("#m_nome_usuario").val(param.nm_nome);
                    $("#m_sobrenome_usuario").val(param.nm_sobrenome);
                    $("#m_email_usuario").val(param.nm_email);
                    $("#m_telefone_usuario").val(param.nm_telefone);
                    $("#m_endereco_usuario").val(param.nm_endereco);
                    $("#formConsulta").show();
                });
            },
            error: function () {
                alert("Erro ao Consultar o Banco de Dados.<br />Tente novamente ou entre em contato com o suporte do sistema!");
            }
        });
    });
}



$(function () {
    LoadPage();
    ComandosTela();
});