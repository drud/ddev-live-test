<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Extension\SandboxExtension;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* core/profiles/demo_umami/themes/umami/templates/components/footer-promo-block/block--bundle--footer-promo-block.html.twig */
class __TwigTemplate_cc1c43f39aa24b5a6a19c8fc6a7c308e5c1adaf0c621bccfea645484689e31ce extends \Twig\Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = [
            'content' => [$this, 'block_content'],
        ];
        $this->sandbox = $this->env->getExtension('\Twig\Extension\SandboxExtension');
        $tags = array("if" => 31, "block" => 37);
        $filters = array("escape" => 28, "without" => 40);
        $functions = array();

        try {
            $this->sandbox->checkSecurity(
                ['if', 'block'],
                ['escape', 'without'],
                []
            );
        } catch (SecurityError $e) {
            $e->setSourceContext($this->source);

            if ($e instanceof SecurityNotAllowedTagError && isset($tags[$e->getTagName()])) {
                $e->setTemplateLine($tags[$e->getTagName()]);
            } elseif ($e instanceof SecurityNotAllowedFilterError && isset($filters[$e->getFilterName()])) {
                $e->setTemplateLine($filters[$e->getFilterName()]);
            } elseif ($e instanceof SecurityNotAllowedFunctionError && isset($functions[$e->getFunctionName()])) {
                $e->setTemplateLine($functions[$e->getFunctionName()]);
            }

            throw $e;
        }

    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        // line 28
        echo "<div";
        echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(($context["attributes"] ?? null), 28, $this->source), "html", null, true);
        echo ">
  ";
        // line 29
        echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(twig_get_attribute($this->env, $this->source, ($context["content"] ?? null), "field_media_image", [], "any", false, false, true, 29), 29, $this->source), "html", null, true);
        echo "
  ";
        // line 30
        echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(($context["title_prefix"] ?? null), 30, $this->source), "html", null, true);
        echo "
  ";
        // line 31
        if (($context["label"] ?? null)) {
            // line 32
            echo "    <h2";
            echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(($context["title_attributes"] ?? null), 32, $this->source), "html", null, true);
            echo ">";
            echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(($context["label"] ?? null), 32, $this->source), "html", null, true);
            echo "</h2>
  ";
        } elseif (twig_get_attribute($this->env, $this->source,         // line 33
($context["content"] ?? null), "field_title", [], "any", false, false, true, 33)) {
            // line 34
            echo "    <h2";
            echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(($context["title_attributes"] ?? null), 34, $this->source), "html", null, true);
            echo ">";
            echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(twig_get_attribute($this->env, $this->source, ($context["content"] ?? null), "field_title", [], "any", false, false, true, 34), 34, $this->source), "html", null, true);
            echo "</h2>
  ";
        }
        // line 36
        echo "  ";
        echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->sandbox->ensureToStringAllowed(($context["title_suffix"] ?? null), 36, $this->source), "html", null, true);
        echo "
  ";
        // line 37
        $this->displayBlock('content', $context, $blocks);
        // line 46
        echo "</div>
";
    }

    // line 37
    public function block_content($context, array $blocks = [])
    {
        $macros = $this->macros;
        // line 38
        echo "    <div class=\"footer-promo-content\">
      ";
        // line 39
        if ( !($context["label"] ?? null)) {
            // line 40
            echo "        ";
            echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->extensions['Drupal\Core\Template\TwigExtension']->withoutFilter($this->extensions['Drupal\Core\Template\TwigExtension']->withoutFilter($this->sandbox->ensureToStringAllowed(($context["content"] ?? null), 40, $this->source), "field_title"), "field_media_image"), "html", null, true);
            echo "
      ";
        } else {
            // line 42
            echo "        ";
            echo $this->extensions['Drupal\Core\Template\TwigExtension']->escapeFilter($this->env, $this->extensions['Drupal\Core\Template\TwigExtension']->withoutFilter($this->sandbox->ensureToStringAllowed(($context["content"] ?? null), 42, $this->source), "field_media_image"), "html", null, true);
            echo "
      ";
        }
        // line 44
        echo "    </div>
  ";
    }

    public function getTemplateName()
    {
        return "core/profiles/demo_umami/themes/umami/templates/components/footer-promo-block/block--bundle--footer-promo-block.html.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  128 => 44,  122 => 42,  116 => 40,  114 => 39,  111 => 38,  107 => 37,  102 => 46,  100 => 37,  95 => 36,  87 => 34,  85 => 33,  78 => 32,  76 => 31,  72 => 30,  68 => 29,  63 => 28,);
    }

    public function getSourceContext()
    {
        return new Source("", "core/profiles/demo_umami/themes/umami/templates/components/footer-promo-block/block--bundle--footer-promo-block.html.twig", "/var/www/html/web/core/profiles/demo_umami/themes/umami/templates/components/footer-promo-block/block--bundle--footer-promo-block.html.twig");
    }
}
