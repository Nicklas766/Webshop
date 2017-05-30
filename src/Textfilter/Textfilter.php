<?php
namespace nicklas\Textfilter;

// Example how it works
// $textfilter = new Textfilter();
// $text = $textfilter->doFilter($textOrig, "bbcode,markdown,link");

class Textfilter
{
    /**
     * Call each filter.
     *
     * @deprecated deprecated since version 1.2 in favour of parse().
     *
     * @param string       $text    the text to filter.
     * @param string|array $filters as comma separated list of filter,
     *                              or filters sent in as array.
     *
     * @return string the formatted text.
     */
    public function doFilter($text, $filters)
    {
        // if filters is empty, have markdown as default
        if ($filters == "") {
            $filters = "markdown";
        }
        // Define all valid filters with their callback function.
        $callbacks = [
            'bbcode'    => 'bbcode2html',
            'link'      => 'makeClickable',
            'markdown'  => 'markdown',
            'nl2br'     => 'nl2br',
        ];

        // Make an array of the comma separated string $filters
        if (is_array($filters)) {
            $filter = $filters;
        } else {
            $filters = strtolower($filters);
            $filter = preg_replace('/\s/', '', explode(',', $filters));
        }

        // For each filter, call its function with the $text as parameter.
        foreach ($filter as $key) {
            if (!isset($callbacks[$key])) {
                throw new TextException("The filter '$filters' is not a valid filter string due to '$key'.");
            }
            $text = call_user_func_array([$this, $callbacks[$key]], [$text]);
        }

        return $text;
    }
    /**
    * Helper, BBCode formatting converting to HTML.
    *
    * @param string text The text to be converted.
    * @returns string the formatted text.
    */
    public function bbcode2html($text)
    {
          $search = array(
            '/\[b\](.*?)\[\/b\]/is',
            '/\[i\](.*?)\[\/i\]/is',
            '/\[u\](.*?)\[\/u\]/is',
            '/\[img\](https?.*?)\[\/img\]/is',
            '/\[url\](https?.*?)\[\/url\]/is',
            '/\[url=(https?.*?)\](.*?)\[\/url\]/is'
            );
          $replace = array(
            '<strong>$1</strong>',
            '<em>$1</em>',
            '<u>$1</u>',
            '<img src="$1" />',
            '<a href="$1">$1</a>',
            '<a href="$1">$2</a>'
            );
          return preg_replace($search, $replace, $text);
    }

    /**
     * Make clickable links from URLs in text.
     *
     * @param string $text the text that should be formatted.
     *
     * @return string with formatted anchors.
     *
     * @link http://dbwebb.se/coachen/lat-php-funktion-make-clickable-automatiskt-skapa-klickbara-lankar
     */
    public function makeClickable($text)
    {
        return preg_replace_callback(
            '#\b(?<![href|src]=[\'"])https?://[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/))#',
            function ($matches) {
                return "<a href='{$matches[0]}'>{$matches[0]}</a>";
            },
            $text
        );
    }

    /**
     * Format text according to Markdown syntax.
     *
     * @param string $text the text that should be formatted.
     *
     * @return string as the formatted html-text.
     */
    public function markdown($text)
    {
        $text = \Michelf\MarkdownExtra::defaultTransform($text);
        $text = \Michelf\SmartyPantsTypographer::defaultTransform(
            $text,
            "2"
        );
        return $text;
    }

    /**
     * For convenience access to nl2br
     *
     * @param string $text text to be converted.
     *
     * @return string the formatted text.
     */
    public function nl2br($text)
    {
        return nl2br($text);
    }

    // controls if the indexes in array is in the other sent in array
    public function controlInput($sentValues)
    {
        // create array with the sentValues
        $sentValues = explode(",", $sentValues);

        // Define all valid filters
        $correctValues = ['bbcode', 'link', 'markdown', 'nl2br'];

        // start foreach and control if value in array
        foreach ($sentValues as $key => $value) {
            if (!in_array($value, array_values($correctValues))) {
                return false;
            }
        }
        return true;
    }
}
