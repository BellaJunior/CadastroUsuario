//Deve ter a URL da aplicação quando nao for localhost
var UrlAplicacao = ""

function LoadPage() {
    $("#m_nome_usuario").val("");
    $("#m_sobrenome_usuario").val("");
    $("#m_email_usuario").val("");
    $("#m_telefone_usuario").val("");
    $("#m_endereco_usuario").val("");
    $(".is-invalid").removeClass("is-invalid");
}

function ValidaForm() {
    var retorno = true;
    if ($("#m_nome_usuario").val() == "") {
        retorno = false;
        $("#m_nome_usuario").addClass("is-invalid");
    }
    if ($("#m_sobrenome_usuario").val() == "") {
        retorno = false;
        $("#m_sobrenome_usuario").addClass("is-invalid");
    }
    if ($("#m_email_usuario").val() == "") {
        retorno = false;
        $("#m_email_usuario").addClass("is-invalid");
    }
    if ($("#m_telefone_usuario").val() == "") {
        retorno = false;
        $("#m_telefone_usuario").addClass("is-invalid");
    }
    if ($("#m_endereco_usuario").val() == "") {
        retorno = false;
        $("#m_endereco_usuario").addClass("is-invalid");
    }
    return retorno;
}

function ComandosTela() {
    //Click do Gravar
    $("#btn_gravar").click(function () {
        if (!ValidaForm()) {
            alert("Todos os campos devem ser preenchidos!")
            return false;
        }

        $.ajax({
            url: UrlAplicacao + '/CadUsuario/InsereUsuario',
            async: true,
            type: "GET",
            dataType: 'json',
            data: {
                nm_nome: $("#m_nome_usuario").val(),
                nm_sobrenome: $("#m_sobrenome_usuario").val(),
                nm_email: $("#m_email_usuario").val(),
                nm_telefone: $("#m_telefone_usuario").val(),
                nm_endereco: $("#m_endereco_usuario").val()
            },
            success: function (response) {
                if (response != "ERRO") {
                    alert("Alteração realizada com sucesso!");
                    LoadPage();
                }
                else
                    alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            },
            error: function () {
                alert("Erro ao Consultar o Banco de Dados.\nTente novamente ou entre em contato com o suporte do sistema!");
            }
        });
    });

    //Click do Cancelar
    $("#btn_cancelar").click(function () {
        LoadPage();
    });

    //Limpa validador
    $("input").change(function () {
        $(this).removeClass("is-invalid");
    });
}

$(function () {
    LoadPage();
    ComandosTela();
});