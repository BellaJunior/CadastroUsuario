using System.Linq;
using System.Web.Mvc;
using TesteSeniorSolution.Models;

namespace TesteSeniorSolution.Controllers
{
    public class CadUsuarioController : Controller
    {
        // GET: CadUsuario
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult InsereUsuario(tb_usuario_det detUsuario, tb_usuario usuario)
        {
            try
            {
                //Insere tabela de detalhe do usuario
                using (var context = new TesteSeniorSolutionEntities())
                {
                    context.tb_usuario_det.Add(new tb_usuario_det()
                    {
                        nm_endereco = detUsuario.nm_endereco,
                        nm_telefone = detUsuario.nm_telefone
                    });
                    context.SaveChanges();

                    //Recupera id do detalhe para gravar a tabela de usuario
                    usuario.cd_id_detalhe = (from r in context.tb_usuario_det
                                             orderby r.cd_id_detalhe descending
                                             select r).First().cd_id_detalhe;
                }

                //Insere tabela de usuario
                if (InsereTb_usuario(usuario))
                    return base.Json("msg: Sucesso", JsonRequestBehavior.AllowGet);
                else
                {
                    //Em caso de erro ao incluir registro do usuário excluir detalhe incluído do mesmo
                    using (var context = new TesteSeniorSolutionEntities())
                    {
                        tb_usuario_det detalheRemover = context.tb_usuario_det.First(p => p.cd_id_detalhe == usuario.cd_id_detalhe);
                        context.tb_usuario_det.Remove(detalheRemover);
                        context.SaveChanges();
                    }

                    return base.Json("msg: Erro", JsonRequestBehavior.AllowGet);
                }
            }
            catch
            {
                return base.Json("msg: Erro", JsonRequestBehavior.AllowGet);
            }
        }

        public bool InsereTb_usuario(tb_usuario usuario)
        {
            try
            {
                using (var context = new TesteSeniorSolutionEntities())
                {
                    context.tb_usuario.Add(new tb_usuario()
                    {
                        cd_id_detalhe = usuario.cd_id_detalhe,
                        nm_nome = usuario.nm_nome,
                        nm_sobrenome = usuario.nm_sobrenome,
                        nm_email = usuario.nm_email
                    });
                    context.SaveChanges();

                    usuario.cd_id_detalhe = (from r in context.tb_usuario_det
                                             orderby r.cd_id_detalhe descending
                                             select r).First().cd_id_detalhe;
                }

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}