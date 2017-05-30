<?php

namespace nicklas\Textfilter;

/**
 * Test cases for class Navbar
 */
class TextFilterTest extends \PHPUnit_Framework_TestCase
{
    /**
     * Test case to construct object and verify that the object
     * has the expected properties due various ways of constructing
     * it.
     */
    public function testCreateObject()
    {
        $textFilter = new Textfilter();
        $this->assertInstanceOf("nicklas\Textfilter\Textfilter", $textFilter);
    }

    /**
     * Test case for filter functions
     * Controls that the return is correct regarding to the function.
     */
    public function testFilters()
    {
        $textFilter = new Textfilter();
        // test nl2br
        $this->assertEquals(nl2br("hej"), $textFilter->nl2br("hej"));

        // test markdown
        $htmlString = "<h1>Markdown example</h1>
";
        $markdownString = $textFilter->markdown("# Markdown example");
        $this->assertEquals($htmlString, $markdownString);

        // test clickable
        $clickLink = $textFilter->makeClickable("https://dbwebb.se");
        $hrefLink = "<a href='https://dbwebb.se'>https://dbwebb.se</a>";

        $this->assertEquals($hrefLink, $clickLink);
    }

    /**
     * Test case for function bbcode2html($text)
     * Controls that the return is correct regarding to the function.
     */
    public function testBBCode()
    {
        $textFilter = new Textfilter();

        $hrefLink = '<a href="https://dbwebb.se">länk till dbwebb</a>';
        $clickLink = $textFilter->bbcode2html("[url=https://dbwebb.se]länk till dbwebb[/url]");

        $this->assertEquals($hrefLink, $clickLink);
    }

    /**
     * Test case for main function
      * Uses text and the filters, markdown and link to compare if its correct
     */
    public function testDoFilter()
    {
        $textFilter = new Textfilter();

        // check with markdown and link
        $correctText = "<h1><a href='https://dbwebb.se'>https://dbwebb.se</a></h1>
";
        $text = "# https://dbwebb.se";
        $filtered = $textFilter->doFilter($text, "markdown, link");

        $this->assertEquals($correctText, $filtered);

        // Do same, but with an array as argument.
        $filtered = $textFilter->doFilter($text, ["markdown", "link"]);
        $this->assertEquals($correctText, $filtered);

        // check that markdown is default
        $htmlString = "<h1>Markdown example</h1>
";
        $markdownString = $textFilter->doFilter($htmlString, "");
        $this->assertEquals($htmlString, $markdownString);
    }

    public function testException()
    {
        $textFilter = new Textfilter();
        $text = "# https://dbwebb.se";
        // throws execption if filter doesnt exist
        $this->setExpectedException(TextException::class);
        $textFilter->doFilter($text, "link, doesntexist");
    }

    public function testControlInput()
    {
        $textFilter = new Textfilter();
        $this->assertEquals($textFilter->controlInput("bbcode"), true);
        $this->assertEquals($textFilter->controlInput("markdownNotTrue"), false);
    }
}
