//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TesteSeniorSolution.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class tb_usuario
    {
        public int cd_id_usuario { get; set; }
        public string nm_nome { get; set; }
        public string nm_sobrenome { get; set; }
        public string nm_email { get; set; }
        public int cd_id_detalhe { get; set; }
    
        public virtual tb_usuario_det tb_usuario_det { get; set; }
    }
}
